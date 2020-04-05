module Covid19cli
  class << self
    OPT_DATE = 'date'
    OPT_SORT = 'sort'
    OPT_TOP = 'top'
    OPT_COUNTRY = 'country'
    OPT_USA = 'states'
    OPT_USA_COUNTIES = 'counties'
    OPT_FILTER = 'filter'
    OPT_HISTORY = 'history'
    OPT_KEY = 'key'

    def cli
      require 'covid19cli/version'
      require 'covid19cli/csse'

      require 'optparse'

      puts "\n#{COMMAND} #{VERSION}"

      ARGV << '-h' if ARGV.empty?

      options = {}
      ARGV.options do |opts|
        opts.banner = "Usage: #{COMMAND} \n"\
                      "       #{COMMAND} [options]"

        opts.on("-d", "--#{OPT_DATE} [date]", String)  { |val| options[OPT_DATE] = val }
        opts.on("-s", "--#{OPT_SORT} #{Csse::CONFIRMED}, #{Csse::DEATHS}, #{Csse::DEATH_RATE}", String)  { |val| options[OPT_SORT] = val }
        opts.on("-t", "--#{OPT_TOP} [number]", String)  { |val| options[OPT_TOP] = val }
        opts.on("-c", "--#{OPT_COUNTRY} [country]", String)  { |val| options[OPT_COUNTRY] = val }
        opts.on("--#{OPT_USA}", TrueClass)  { |val| options[OPT_USA] = val }
        opts.on("--#{OPT_USA_COUNTIES}", TrueClass)  { |val| options[OPT_USA_COUNTIES] = val }
        opts.on("-f", "--#{OPT_FILTER} [value]", String)  { |val| options[OPT_FILTER] = val }
        opts.on("--#{OPT_HISTORY}", TrueClass)  { |val| options[OPT_HISTORY] = val }
        opts.on("--#{OPT_KEY} [key]", String)  { |val| options[OPT_KEY] = val }

        opts.on_tail("-h", "--help") { puts opts }

        opts.parse!
      end

      require 'date'

      states = options[OPT_USA]
      counties = options[OPT_USA_COUNTIES]
      if states || counties
        require 'covid19cli/nyt'

        filter = options[OPT_FILTER]

        date = options[OPT_DATE]
        if date.nil?
          date = DateTime.now.strftime(Nyt::DATE_FORMAT) if date.nil?
        else
          date = DateTime.parse(date).strftime(Nyt::DATE_FORMAT)
        end

        if states == true
          type = 'states'
        else
          type = 'counties'
        end

        key = options[OPT_KEY]
        if options[OPT_HISTORY] == true
          if filter.nil? or key.nil?
            puts "historical data, please use -f and --key"
          else
            last = options[OPT_TOP]

            if last.nil?
              puts "#{type} historical data for #{key} = #{filter}"
            else
              puts "last #{last} days #{type} historical data for #{key} = #{filter}"
            end

            list = Nyt.get_data_history(type, key, filter)

            Nyt.print_chart(list, last)
          end
          exit
        end

        list = Nyt.get_data(date, type)

        if list.count == 0
          puts "no data available"
          exit
        end

        sort = options[OPT_SORT]
        sort = 'Cases' if sort.nil?

        top = options[OPT_TOP]
        top = 10 if top.nil?
        top = top.to_i

        begin
          Nyt.print_summary(list, sort, top, date, filter)
        rescue
          begin
            date = Date.today.prev_day.strftime(Nyt::DATE_FORMAT)
            Nyt.print_summary(list, sort, top, date, filter)
          rescue
            date = Date.today.prev_day.prev_day.strftime(Nyt::DATE_FORMAT)
            Nyt.print_summary(list, sort, top, date, filter)
          end
        end
        exit
      end

      date = options[OPT_DATE]
      if date.nil?
        date = DateTime.now.strftime(Csse::DATE_FORMAT) if date.nil?
      else
        date = DateTime.parse(date).strftime(Csse::DATE_FORMAT)
      end

      begin
        list = Csse.get_data(date)
      rescue
        date = Date.today.prev_day.strftime(Csse::DATE_FORMAT)
        list = Csse.get_data(date)
      end

      country = options[OPT_COUNTRY]
      unless country.nil?
        Csse.print_summary_country(list, country)
        exit
      end

      sort = options[OPT_SORT]
      sort = Csse::CONFIRMED if sort.nil?
      # sort.sub! 'dr', Csse::DEATH_RATE
      # sort.sub! Csse::DEATHS.downcase, Csse::DEATHS
      # sort.sub! Csse::CONFIRMED.downcase, Csse::CONFIRMED

      unless [Csse::DEATHS, Csse::CONFIRMED, Csse::DEATH_RATE].include? sort
        puts "invalid sort option, try --#{OPT_SORT} #{Csse::CONFIRMED.downcase}, #{Csse::DEATHS.downcase}, dr"
        exit
      end

      top = options[OPT_TOP]
      top = 20 if top.nil?
      top = top.to_i

      Csse.print_summary(list, sort, top)
    end

  end # class

end # module
