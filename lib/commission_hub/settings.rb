module CommissionHub
  class Settings

    include Singleton

    attr_accessor :debug_output

    def initialize
      @confs = {}
    end

    def setup(name, &blk)
      namespace = name.to_s.camelcase
      settings  = @confs[name] || "CommissionHub::#{namespace}::Settings".constantize.new
      settings.instance_eval(&blk) if blk
      @confs[name] = settings
      rescue  NoMethodError => e
        raise e
      rescue NameError => e
        raise "CommissionHub::#{namespace}::Settings class is missing. Refer to
        https://github.com/lemmoney/commission_hub for more information"
    end

  end
end
