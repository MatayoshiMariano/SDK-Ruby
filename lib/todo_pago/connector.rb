require 'savon'
require 'paper_cup'
require_relative "endpoint"

module TodoPago

  class Connector

    attr_accessor :header_http, :wsdl, :end_point

    def initialize(header_http, wsdls, endpoint)
      @header_http = header_http
      @wsdls = wsdls
      @endpoint = endpoint # the endpoint incompleted
    end

    # Class method that create a client that access to the service via SOAP using Savon
    def self.getClientSoap(wsdl_service, endpoint_sufix)
      Savon.client(headers: header_http, wsdl: wsdl_service,
                   endpoint: end_point + TodoPago::SOAP_APPEND + TodoPago::SENANT + endpoint_sufix,
                   log: false, log_level: :debug, ssl_verify_mode: :none, convert_request_keys_to: :none)
    end

    def self.buildPayload(optionAuthorize)
      xml = "<Request>"
      binding.pry
      optionAuthorize.each do |item|
        xml = xml.concat("<")
                   .concat(item[0].to_s)
                   .concat(">")
                   .concat(item[1])
                   .concat("</")
                   .concat(item[0].to_s)
                   .concat(">")
      end
      xml.concat("</Request>");
    end

    #Public method that call the first function of the service SendAuthorizeRequest
    def sendAuthorizeRequest(options_comercio, options_operacion)
      message = {
                  Security: options_comercio[:security],
                  Merchant: options_comercio[:MERCHANT],
                  EncodingMethod: options_comercio[:EncodingMethod],
                  URL_OK: options_comercio[:URL_OK],
                  URL_ERROR: options_comercio[:URL_ERROR],
                  EMAILCLIENTE: options_comercio[:EMAILCLIENTE],
                  Session: options_comercio[:Session],
                  Payload: TodoPagoConector.buildPayload(options_operacion)
                }
      client = TodoPagoConector.getClientSoap($j_wsdls['Authorize'], 'Authorize')
      response = client.call(:send_authorize_request, message: message)
      return response.hash
    end
    #####################################################################################
    ###Methodo publico que llama a la segunda funcion del servicio GetAuthorizeRequest###
    #####################################################################################
    def getAuthorizeRequest(optionsAnwser)
      message = {Security: optionsAnwser[:security],
                 Merchant: optionsAnwser[:MERCHANT],
                 RequestKey: optionsAnwser[:RequestKey],
                 AnswerKey: optionsAnwser[:AnswerKey]};

      client = TodoPagoConector.getClientSoap($j_wsdls['Authorize'], 'Authorize')
      response= client.call(:get_authorize_answer,message:message)
      return response.hash
    end

    ############################################################
    ###Methodo publico que retorna el status de una operacion###
    ############################################################
    def getOperations(optionsOperations)
      url = TodoPago::Endpoint.operation_status(endpoint, optionsOperations[:MERCHANT], optionsOperations[:OPERATIONID])
      PaperCup.get url
    end
    ################################################################
    ###Methodo publico que descubre todas las promociones de pago###
    ################################################################
    def getAllPaymentMethods(optionsPaymentMethod)
      url = TodoPago::Endpoint.all_payment_methods(endpoint, optionsOperations[:MERCHANT])
      PaperCup.get url
    end
  end
end
