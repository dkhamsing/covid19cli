module Csse
  DATE_FORMAT = '%m-%d-%Y'

  COUNTRY = 'Country'
  CONFIRMED = 'Confirmed'
  DEATHS = 'Deaths'
  DEATH_RATE = 'Death Rate'

  COUNTRY_REGION = 'Country_Region'
  COUNTRY_REGION2 = 'Country/Region'

  class << self

    # Constants
    URL_BASE = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/'
    CSV_EXTENSION = '.csv'

    # Public
    def get_data(date)
      file = "#{date}.csv"

      begin
        open_data(file)
        puts "reading data from #{date}#{CSV_EXTENSION}"
      rescue => e
        require 'open-uri'

        puts "getting data for #{date}"
        url = "#{URL_BASE}#{date}#{CSV_EXTENSION}"

        begin
          download = open(url)
          IO.copy_stream(download, file)
        rescue => e
          puts "there was an error getting data for #{date}: #{e}"
        end

      end

      return open_data(file)
    end

    CREDITS = 'Data from https://github.com/CSSEGISandData/COVID-19'

    # Public

    def print_summary_country(list, country)
      rows = [Csse.get_data_summary(country, list)]
      output(rows)
    end

    def print_summary(list, sort, top)
      countries = Csse.get_countries(list)
      rows = []

      countries.each { |c|
        rows << Csse.get_data_summary(c, list)
      }

      sorted = sort_rows(rows, sort, top)

      output(sorted)
    end

    def output(data)
      require 'terminal-table'

      formatted = format_data(data)

      table = Terminal::Table.new :headings => [Csse::COUNTRY, Csse::CONFIRMED, Csse::DEATHS, "#{Csse::DEATH_RATE} %"], :rows => formatted
      table.align_column(1, :right)
      table.align_column(2, :right)
      table.align_column(3, :right)
      puts table

      puts CREDITS
    end

    def format_data(data)
      f = []
      data.each do |d|
        f << [ d[Csse::COUNTRY], d[Csse::CONFIRMED], d[Csse::DEATHS], d[Csse::DEATH_RATE] ]
      end

      return f
    end

    def sort_rows(rows, type, top)
      sorted = rows.sort_by { |k| k[type] }
      reverse = sorted.reverse
      subset = reverse[0,top]
      return subset
    end

    def open_data(file)
      require 'csv'
      list = CSV.open(file, headers: :first_row).map(&:to_h)
      return list
    end

    # Aggregates count for countries where data is split over a region (e.g. US).
    def get_aggregate_count(list, country, type)
      count = 0

      list.each do |d|
        key = COUNTRY_REGION
        if d[key] == nil
          key = COUNTRY_REGION2
        end

        if d[key].downcase == country.downcase
          count += d[type].to_i
        end
      end

      return count
    end

    def get_countries(list)
      c = []

      list.each do |d|
        key = COUNTRY_REGION
        if d[key] == nil
          key = COUNTRY_REGION2
        end

        c << d[key] unless c.include? d[key]
      end

      return c
    end

    def get_data_summary(country, list)
      confirmed = get_aggregate_count(list, country, CONFIRMED)
      deaths = get_aggregate_count(list, country, DEATHS)
      death_rate = "#{sprintf('%.2f', deaths.to_f / confirmed * 100)}"

      country.sub! 'Taiwan*', 'Taiwan'
      country.sub! 'Korea, South', 'South Korea'

      return {COUNTRY => country, CONFIRMED => confirmed, DEATHS => deaths, DEATH_RATE => death_rate}
    end

  end #class
end
