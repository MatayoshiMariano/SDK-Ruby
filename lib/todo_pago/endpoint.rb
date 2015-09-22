module TodoPago
  class Endpoint
    class << self
      def all_payment_methods(endpoint, merchant_id)
        [endpoint, TodoPago::TENANT, TodoPago::REST_APPEND, 'PaymentMethods/Get/MERCHANT/', merchant_id].join
      end

      def operation_status(endpoint, merchant_id, operation_id)
        [endpoint, TodoPago::TENANT, TodoPago::REST_APPEND, 'Operations/GetByOperationId/MERCHANT/', merchant_id,
          '/OPERATIONID/', operation_id].join
      end
    end
  end
end
