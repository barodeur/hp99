class ResultsController < ApplicationController
  def index
    @results = Service::Base::IMPLEMENTATIONS.reduce({}) do |hsh, service_class|
      service_sym = service_class.to_s.underscore.split('/').last.to_sym
      hsh[service_sym] = service_class.instance.results
      hsh
    end
    render :layout => false
  end
end
