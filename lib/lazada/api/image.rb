module Lazada
  module API
    module Image
      def set_images(params)
        url = request_url('Image')

        params = { 'ProductImage' => params }
        response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true))

        response
      end

      def migrate_image(image_url)
        url = request_url('MigrateImage')

        params = { 'Image' => { 'Url' => image_url } }
        response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true))

        response['SuccessResponse'].present? ? response['SuccessResponse']['Body']['Image']['Url'] : ''
      end

      def migrate_images(image_url_list)
        url = request_url('MigrateImages')

        # Allow duplicate keys
        urls = {}.compare_by_identity
        image_url_list.each { |url| urls.merge!({ String.new('Url') => url }) }

        params = { 'Images' => urls }

        response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true))

        response['SuccessResponse'].present? ? response['SuccessResponse']['Body']['Image']['Url'] : ''
      end
    end
  end
end
