defmodule PhoenixExample.ScrapeNewsController do
  use PhoenixExample.Web, :controller

  defp remove_xml(str) do
     # <?xml version encoding ?>
     String.replace(str, ~r/^\s*<?.*?>/U, "")
  end

  defp curl(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body}} -> body
      {:error, %HTTPoison.Error{id: _, reason: reason}} -> reason
    end
  end

  defp scrape_msn(path) do
    body = curl("http://www.msn.com/" <> path)
    body
    |> remove_xml
    |> Select.parse
    |> Select.find([{:attr, "id", "main"}, {:class, "normalsection"}])
    |> Select.html
    |> IO.iodata_to_binary
  end

  # scrape rss feed
  defp scrape_sdtimes() do
    body = curl("http://sdtimes.com/feed/")
    {:ok, feed, _} = FeederEx.parse(body)
    list = Enum.map(feed.entries, &sdtimes_entry(&1))
    "<ul class=\"sdtimes\">" <> Enum.join(list) <> "</ul>"
  end

  defp sdtimes_entry(entry) do
     "<li><a href=\"#{entry.link}\" target=_blank class=\"sdentry\">#{entry.title}</a><div class=\"summary\">#{entry.summary}</div></li>"
  end

  defp scrape_dilbert do
    body = curl("http://dilbert.com/")
    body
    |> remove_xml
    |> Select.parse
    |> Select.find([{:class, "img-comic-link"}, {:name, "img"}])
    |> Select.html
    |> IO.iodata_to_binary
  end

  def index(conn, _params) do
    dilbert = scrape_dilbert()
    msn_gb  = scrape_msn("en-gb/news")
    msn_us  = scrape_msn("en-us/news")
    sdtimes = scrape_sdtimes()
    render conn, "index.html", [dilbert: dilbert, msn_gb: msn_gb, msn_us: msn_us, sdtimes: sdtimes]
  end

end
