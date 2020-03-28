module Covid19cli
  require 'covid19cli/version'

  class << self

    def cli
      require 'optparse'
      require 'date'

      puts "#{COMMAND} #{VERSION}"

      # date = "03-25-2021"
      date = DateTime.now.strftime('%m-%d-%Y')
      list = get_data(date)
      summary(list)

      # ARGV << '-h' if ARGV.empty?
      #
      # options = {}
      # ARGV.options do |opts|
      #   opts.banner = "usage: #{COMMAND} --summary"\
      #
      #   opts.on("-s", "--summary")  { summary }
      #
      #
      #   opts.on_tail("-h", "--help") {
      #     puts opts
      #     puts "\n"
      #     summary
      #   }
      #   opts.parse!
      # end

    end

    def summary(list)
      require 'terminal-table'

      rows = []
      rows << output_summary('Italy', list)
      rows << output_summary('US', list)
      rows << output_summary('China', list)
      rows << output_summary('Spain', list)

      rows << output_summary('Germany', list)
      rows << output_summary('Iran', list)
      rows << output_summary('France', list)
      rows << output_summary('Switzerland', list)

      rows << output_summary('United Kingdom', list)
      rows << output_summary('Korea, South', list)
      rows << output_summary('Netherlands', list)
      rows << output_summary('Belgium', list)

      rows << output_summary('Austria', list)
      rows << output_summary('Canada', list)
      rows << output_summary('Norway', list)
      rows << output_summary('Australia', list)

      rows << output_summary('Taiwan*', list)
      rows << output_summary('Japan', list)

      table = Terminal::Table.new :headings => ['Country', 'Confirmed', 'Deaths', 'Death Rate'], :rows => rows
      table.align_column(1, :right)
      table.align_column(2, :right)
      table.align_column(3, :right)
      puts table
    end

    def get_data(date)
      file = "#{date}.csv"

      begin
        open_data(file)
        puts "reading data from #{date}.csv"
      rescue => e
        require 'open-uri'

        puts "getting data for #{date}"
        url = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/#{date}.csv"

        begin
          download = open(url)
          IO.copy_stream(download, file)
        rescue => e
          puts "oops could not get data for #{date}: #{e}"
          exit
        end

      end

      return open_data(file)
    end

    def open_data(file)
      require 'csv'
      list = CSV.open(file, headers: :first_row).map(&:to_h)
      return list
    end

    def confirmedForRegion(list, region, type)
      count = 0

      list.each do |d|
        if d['Country_Region'] == region
          count += d[type].to_i
        end
      end
      return count
    end

    def output_summary(region, list)
      conf = confirmedForRegion(list, region, 'Confirmed')
      deat = confirmedForRegion(list, region, 'Deaths')
      dr = (deat.to_f / conf * 100).round(2)

      region.sub! 'Taiwan*', 'Taiwan'
      region.sub! 'Korea, South', 'South Korea'

      return [region, conf, deat, "#{dr}%"]
    end

  end # class

end # module
