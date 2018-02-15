# Todoable namespace
module Todoable
  # Wrapper module around the endpoint methods
  module Routes
    def all_lists(options: {})
      options[:headers] = protected_headers
      self.class.get('/lists', options)
    end

    def create_list(name: nil, options: {})
      raise ArgumentError, 'name is required' if name.nil?

      options[:headers] = protected_headers
      options[:body] = { list: { name: name } }.to_json
      self.class.post('/lists', options)
    end

    def get_list(list_id: nil, options: {})
      raise ArgumentError, 'list_id is required' if list_id.nil?

      options[:headers] = protected_headers
      self.class.get("/lists/#{list_id}", options)
    end

    def edit_list(list_id: nil, name: nil, options: {})
      if list_id.nil? || name.nil?
        raise ArgumentError, 'list_id, name are required'
      end

      options[:headers] = protected_headers
      options[:body] = { list: { name: name } }.to_json
      self.class.patch("/lists/#{list_id}", options)
    end

    def delete_list(list_id: nil, options: {})
      raise ArgumentError, 'list_id is required' if list_id.nil?

      options[:headers] = protected_headers
      self.class.delete("/lists/#{list_id}", options)
    end

    def create_item(list_id: nil, name: nil, options: {})
      if list_id.nil? || name.nil?
        raise ArgumentError, 'list_id, name are required'
      end

      options[:headers] = protected_headers
      options[:body] = { item: { name: name } }.to_json
      self.class.post("/lists/#{list_id}/items", options)
    end

    def finish_item(list_id, item_id, options: {})
      options[:headers] = protected_headers
      self.class.put("/lists/#{list_id}/items/#{item_id}/finish", options)
    end

    def delete_item(list_id, item_id, options: {})
      if list_id.nil? || item_id.nil?
        raise ArgumentError, 'list_id, item_id are required'
      end

      options[:headers] = protected_headers
      self.class.delete("/lists/#{list_id}/items/#{item_id}", options)
    end
  end
end