module Nyt
  DATE_FORMAT = '%Y-%m-%d'

  class << self
    CSV_EXTENSION = '.csv'
    CREDITS = 'Data from https://github.com/nytimes/covid-19-data'

    def get_data_history(type, key, filter)
      file = "history-#{type}-nyt.csv"

      begin
        require 'open-uri'
        url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-#{type}.csv"
        download = open(url)
        IO.copy_stream(download, file)
      rescue => e
        puts "there was an error getting data for: #{e}"
      end

      return open_data_historical(file, type, key, filter)
    end

    def open_data_historical(file, type, key, filter)
      require 'csv'
      list = CSV.open(file, headers: :first_row).map(&:to_h)

      typelist = list.select { |e| e[key] != nil}.select { |e| e[key].downcase == filter.downcase }

      exit if typelist.count == 0

      return typelist
    end

    def bar(num)
      o = ''

      for i in 0..num
        o << '.'
      end

      return o
    end

    def format_history(list)
      rows = []

      column_max = 12
      death_max = list.last['deaths'].to_i

      prev_deaths = 0
      prev_cases = 0
      list.each { |s|
        deaths = s['deaths'].to_i

        new_deaths = deaths - prev_deaths

        if death_max == 0
          num = 0
        else
          num = deaths * column_max / death_max
        end
        bar = bar(num)

        cases = s['cases'].to_i

        new_cases = cases - prev_cases

        date = s['date'].sub('2020-','')
        death_rate = "#{sprintf('%.2f', deaths.to_f / cases.to_i * 100)}"

        rows << [ date, s['state'], s['county'], cases, new_cases, deaths, new_deaths, death_rate, bar]

        prev_deaths = deaths
        prev_cases = cases
      }

      return rows
    end

    def print_chart(list, last)
      require 'terminal-table'

      r = format_history(list)
      unless last.nil?
        count = r.count
        r = r[count-last.to_i,count]
      end

      h = ['Date', 'State', 'County', 'Cases', 'New Cases', 'Deaths', 'New Deaths', 'Death Rate %', 'Death Plot']

      table = Terminal::Table.new :headings => h, :rows => r
      table.align_column(3, :right)
      table.align_column(4, :right)
      table.align_column(5, :right)
      table.align_column(6, :right)
      table.align_column(7, :right)

      puts table

      puts CREDITS
    end

    def get_data(date, type)
      puts "get data date = #{date}"

      file = "#{date}-#{type}-nyt.csv"

      begin
        open_data(file)
        puts "reading data from the #{CSV_EXTENSION} file"
      rescue => e
        require 'open-uri'

        puts "getting data for #{date}"
        url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-#{type}.csv"

        begin
          download = open(url)
          IO.copy_stream(download, file)
        rescue => e
          puts "there was an error getting data for #{date}: #{e}"
        end

      end

      return open_data(file, date)
    end

    def open_data(file, date)
      require 'csv'
      list = CSV.open(file, headers: :first_row).map(&:to_h)

      # check if data is available
      daylist = list.select { |e| e['date'] == date }

      puts "data for #{date}"

      File.delete(file) if daylist.count == 0

      return daylist
    end

    def print_summary(daylist, sort, top, date, filter)
      rows = []

      unless filter.nil?
        daylist.select! { |k| k['state'].downcase == filter.downcase }
      end

      daylist.each { |selected|
        state = selected['state']
        county = selected['county']
        confirmed = selected['cases'].to_i
        deaths = selected['deaths'].to_i
        death_rate = "#{sprintf('%.2f', deaths.to_f / confirmed * 100)}"
        rows << {'State' => state, 'County' => county, 'Cases' => confirmed, 'Deaths' => deaths, 'Death Rate' => death_rate}
      }

      sorted = sort_rows(rows, sort, top)

      output(sorted)
    end

    def sort_rows(rows, type, top)
      sorted = rows.sort_by { |k| k[type] }
      reverse = sorted.reverse
      subset = reverse[0,top]

      return subset
    end

    def output(data)
      require 'terminal-table'

      formatted = format_data(data)

      table = Terminal::Table.new :headings => ['State', 'County', 'Cases', 'Deaths', "Death Rate %"], :rows => formatted
      table.align_column(2, :right)
      table.align_column(3, :right)
      table.align_column(4, :right)
      puts table

      puts CREDITS
    end

    def format_data(data)
      f = []
      data.each do |d|
        f << [ d['State'], d['County'], d['Cases'], d['Deaths'], d['Death Rate'] ]
      end

      return f
    end

  end #class

end
