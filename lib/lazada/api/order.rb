module Lazada
  module API
    module Order
      def get_orders(options = {})
        url = request_url('GetOrders')
        params = {}
        params['Status'] = options[:status] if options[:status].present?
        params['CreatedAfter'] = options[:created_after] if options[:created_after]

        url = request_url('GetOrders', params) if params.present?
        response = self.class.get(url)

        unless response.code == 200
          raise("Lazada API Orders problem. Code #{response&.code}. Response: #{response.inspect}")
        end

        return response['SuccessResponse']['Body']['Orders'] if response['SuccessResponse'].present?
        response
      end

      def get_order(id)
        url = request_url('GetOrder', { 'OrderId' => id })
        response = self.class.get(url)

        return response['SuccessResponse']['Body']['Orders'] if response['SuccessResponse'].present?
        response
      end

      def get_order_items(id)
        url = request_url('GetOrderItems', { 'OrderId' => id })
        response = self.class.get(url)

        return response['SuccessResponse']['Body']['OrderItems'] if response['SuccessResponse'].present?
        response
      end
    end
  end
end
