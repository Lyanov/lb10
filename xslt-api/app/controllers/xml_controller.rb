

class XmlController < ApplicationController

    before_action :parse_params, only: :index

    def index
        find_armstrongs(params[:param])

        respond_to do |format|
            format.xml { render xml: @result.map { |elem| {elem: elem } }.to_xml }
            format.rss { render xml: @result.map { |elem| {elem: elem } }.to_xml }
        end

    end

    protected

    def parse_params
        @param = params[:param]
    end

    private

    def armstrong_number?(arg)
        number = arg.to_s.length
        arg == arg.to_s.split('').map(&:to_i).map { |elem| elem**number }.inject(&:+)
    end


    def find_armstrongs(arg)
        if arg == '' || arg.to_i.nil? || arg.to_i.zero?
            @result = 'There is no data or the data is incorrect'
            nil
        else
            @result = []
            ((10**(params[:param].to_i - 1))..(10**params[:param].to_i - 1)).each do |i|
                @result << i if armstrong_number?(i)
            end
        end
    end


end
