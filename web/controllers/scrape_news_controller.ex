defmodule PhoenixExample.ScrapeNewsController do
  use PhoenixExample.Web, :controller
  alias PhoenixExample.ScrapeNews

  def index(conn, _params) do
    scraped_content = ScrapeNews.scrape_news()
    dilbert = scraped_content["dilbert"]
    msn_gb  = scraped_content["msn_gb"]
    msn_us  = scraped_content["msn_us"]
    sdtimes = scraped_content["sdtimes"]
    
    render conn, "index.html", [dilbert: dilbert, msn_gb: msn_gb, msn_us: msn_us, sdtimes: sdtimes]
  end

end
