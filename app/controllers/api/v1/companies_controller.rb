require 'httparty'
require 'nokogiri'
require 'json'
class Api::V1::CompaniesController < ApplicationController
    
  
    def index
        @companies=Company.all
        render json: @companies.as_json(only: [:c_code, :c_name])
        # ,include: {:stocks => { :only => [:date, :open, :close, :high, :low, :volume, :value ] }})
    end

    def as_json(options={})
      super(only: [:c_code, :c_name])
            
    end

    def show
        @company = Company.find(params[:id])
    end

    
  def scrape
    @links=Array.new
    @alphabets=Array.new
    @alphabets.push('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','others')
    @alphabets.each do |alphabet|
    url = 'https://www.moneycontrol.com/india/stockpricequote/'+alphabet+''
    page = scrape_page(url)
    @links.push(page.css('a.bl_12'))
    end
    return @links
 end

  def save_data
    scrape()
    @links.each do |link|
      link.each do |company_link|
        if !(company_link.children.presence==nil)
          if !(company_link.children[0].text.presence==nil)
            code= company_link.attributes['href'].value.split('/').last
            company_name= company_link.children[0].text
            @company=Company.new
            @company.c_name=company_name
            @company.c_code=code
            @company.save
          end
        end
      end
    end
    
  end

  def chart
   
    @companies=Company.all
    @companies.each do |company|
        code=company.c_code
          charturl='https://www.moneycontrol.com/mc/widget/basicchart/get_chart_value?classic=true&sc_did='+code+'&dur=2yr'
          page = scrape_page(charturl)
          page=JSON.parse(page)["g1"]
          if page==nil
            company.stocks.create()
          else
            page.each do |chart|
              date=chart["date"]
              open=chart["open"]
              high=chart["high"]
              low=chart["low"]
              close=chart["close"]
              volume=chart["volume"]
              value=chart["value"]
              company.stocks.create(:date=>date,:high=>high,:low=>low,:open=>open,:close=>close,:volume=>volume,:value=>value)
            end 
        end
    end
end


  def scrape_page(url)
    scrape = Nokogiri::HTML(HTTParty.get(url))
  end

  def companydetails
    @id=params[:id]
    @date=params[:date]
    @startdate=params[:startdate]
    @enddate=params[:enddate]
    if params[:sort]==nil
      @sort=@date
    else
      @sort=params[:sort]
    end
    company=Company.find(@id)
    if(@date==nil && @startdate==nil && @enddate==nil)
      @c_details=company.stocks.order(@sort)
    else
      if(@date!="")
      @c_details=company.stocks.where(:date=>@date).order(@sort)
      else
      @c_details=company.stocks.where('date >= ? AND date <= ?', @id,@startdate, @enddate).order(:@sort)
      end
    end  
  end

    
end