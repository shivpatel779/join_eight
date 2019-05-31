# frozen_string_literal: true

module Api
  module V1
    # csv and json file read
    class TestTakersController < ApplicationController
      def file_read
        begin
          file_data = case params[:type]
            when "csv"
              {records: csv_file_read}
            when "json"
              json_file_read
            else
              { error: "Wrong file type." }
            end
          render json: file_data, status: file_data[:error] ? 404 : 200
        rescue Exception => e
          render json: { error: e.message }, status: 400
        end
      end

      private

      def csv_file_read
        require 'csv'
        rows = []
        csv = File.read('/home/yuva/Desktop/join_eight/public/testtaker.csv')
        CSV.parse(csv, headers: true).each do |row|
          rows << row.to_hash
        end
        JSON.parse(rows.to_json)
      end

      def json_file_read
        JSON.parse(File.read('/home/yuva/Desktop/join_eight/public/testtaker.json'))
      end
    end
  end
end
