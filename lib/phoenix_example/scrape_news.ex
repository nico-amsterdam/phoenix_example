defmodule PhoenixExample.ScrapeNews do

  # The timeout you fill in here depends on your connection speed and how fast the sites are that you scrape. 
  @timeout_ms 8000

  defp remove_xml(str) do
     # <?xml version encoding ?>
     String.replace(str, ~r/^\s*<?.*?>/U, "")
  end

  defp curl(url) do
    case HTTPotion.get(url, [timeout: @timeout_ms]) do
      %HTTPotion.Response{body: body} -> body
      %HTTPotion.ErrorResponse{message: reason} -> to_string(reason)
    end
  end

  defp empty_to_nil(str) do
     if str == "", do: nil, else: str
  end

  defp scrape_msn(path) do
    body = curl("http://www.msn.com/" <> path)
    body
    |> remove_xml
    |> Select.parse
    |> Select.find([{:attr, "id", "main"}, {:class, "normalsection"}])
    |> Select.html
    |> IO.iodata_to_binary
    |> String.replace(~r/href=\"/, "target=\"news\" href=\"//www.msn.com/")
    |> empty_to_nil
  end

  # scrape rss feed
  defp scrape_sdtimes() do
    try do 
      body = curl("https://sdtimes.com/feed/")
      {:ok, feed, _} = FeederEx.parse(body)
      list = Enum.map(feed.entries, &sdtimes_entry(&1))
      "<ul class=\"sdtimes\">" <> Enum.join(list) <> "</ul>"
    rescue
      # for example BadMapError
      _ -> nil
    end
  end

  defp sdtimes_entry(entry) do
     "<li><a href=\"#{entry.link}\" target=_blank class=\"sdentry\">#{entry.title}</a><div class=\"summary\">#{entry.summary}</div></li>"
  end

  defp scrape_dilbert do
    body = curl("https://dilbert.com/")
    body
    |> remove_xml
    |> Select.parse
    |> Select.find([{:class, "img-comic-link"}, {:name, "img"}])
    |> Select.html
    |> IO.iodata_to_binary
    |> empty_to_nil
  end

  defp scrape_msn_gb() do
    scrape_msn("en-gb/news")
  end

  defp scrape_msn_us() do
    scrape_msn("en-us/news")
  end

  def scrape_news() do
    # When everything is available in cache the extra Task.async await slows down the performance, but it doesn't take more than 10 milleseconds in total.

    # I still want to show parts of the page if scraping fails
    dilbert_task  = Task.async(fn -> SimpleMemCache.cache(SimpleMemCache, "dilbert", 241, &scrape_dilbert/0) ||
                                       SimpleMemCache.put(SimpleMemCache, "dilbert",   1, "<p>Couldn't get Dilbert comics. Please try again later.</p>") end)
    msn_gb_task   = Task.async(fn -> SimpleMemCache.cache(SimpleMemCache, "msn_gb",    3, &scrape_msn_gb/0)  || "<p>Couldn't get UK news. Please try again later.</p>" end)
    msn_us_task   = Task.async(fn -> SimpleMemCache.cache(SimpleMemCache, "msn_us",    5, &scrape_msn_us/0)  || "<p>Couldn't get US news. Please try again later.</p>" end)
    sdtimes_task  = Task.async(fn -> SimpleMemCache.cache(SimpleMemCache, "sdtimes",   9, &scrape_sdtimes/0) || "<p>Couldn't get sd times news. Please, retry 10 minutes later.</p>" end)
    # Timeout for HTTPoison is set to 1 sec. connection time and 1 sec. receive time
    start = :os.system_time(:milli_seconds)
    # there are limitations of what can be done in parallel. Timeout is 8000 milliseconds per request.
    end_at = start + @timeout_ms + 500
    # Task await exits on a timeout, which means that this endpoint will exit and the error page for the HTTP 500 status will be shown.
    dilbert = Task.await(dilbert_task, time_left(end_at))
    msn_gb  = Task.await(msn_gb_task, time_left(end_at))
    msn_us  = Task.await(msn_us_task, time_left(end_at))
    sdtimes = Task.await(sdtimes_task, time_left(end_at))
    %{ "dilbert" => dilbert, "msn_gb" => msn_gb, "msn_us" => msn_us, "sdtimes" => sdtimes}
  end

  defp time_left(end_at_millisec) do
    # 10 bonus milliseconds if time is up.
    max(10, end_at_millisec - :os.system_time(:milli_seconds))
  end

end
