require "spec_helper"
require 'pry'

describe CommissionHub::Settings do
  
  describe '.setup' do
    
    it 'raises an error if affiliator settings is missing' do
      subject = described_class.instance
      expect {subject.setup(:foo_affiliator)}.to raise_error(NameError)
    end

    before (:each) do
      module CommissionHub
        module MyAffiliator
          class Settings
            attr_accessor :user, :password, :api_key
          end
        end
      end
    end

    [:my_affiliator, 'my_affiliator', 'MyAffiliator'].each do |klass|
      context "when #{klass} is given" do 
        it 'returns an instance of an affiliator settings class' do
          subject = described_class.instance
          expect(subject.setup(klass)).to be_an_instance_of(CommissionHub::MyAffiliator::Settings)
        end
      end
    end

    it 'sets instance values on affiliator settings' do
      subject = described_class.instance
        
      affiliator_settings = subject.setup(:my_affiliator) do |my_affiliator_conf|
        my_affiliator_conf.user     = 'user'
        my_affiliator_conf.password = 'password'
        my_affiliator_conf.api_key  = '12345678'
      end
      
      expect(affiliator_settings.user).to eq('user')
      
    end

    it 'raises an error if instance value is missing' do
      subject = described_class.instance
        
      expect {
        subject.setup(:my_affiliator) do |my_affiliator_conf|
          my_affiliator_conf.user     = 'user'
          my_affiliator_conf.password = 'password'
          my_affiliator_conf.api_key  = '12345678'
          my_affiliator_conf.missing_param = 'this param is missing'
        end
      }.to raise_error
      
    end
    
  end


end

