module Podcastinator

  class Feed

    FIELDS = %i(
      author
      copyright
      description
      image_url
      items
      keywords
      language
      owner_name
      owner_email
      subtitle
      title
      url
    )

    FIELDS.each { |field| attr_reader field }

    def initialize(options = {})
      FIELDS.each do |field|
        instance_variable_set("@#{ field }", options[field] || options[field.to_s])
      end
    end

    class Item

      FIELDS = %i(
        author
        duration
        file_size
        guid
        image_url
        keywords
        mime_type
        subtitle
        summary
        time
        title
        url
      )

      FIELDS.each { |field| attr_reader field }

      def initialize(options = {})
        FIELDS.each do |field|
          instance_variable_set("@#{ field }", options[field] || options[field.to_s])
        end
      end

      def is_guid_permalink?
        URI.parse(@guid).kind_of?(URI::HTTP)
      rescue URI::InvalidURIError
        false
      end

    end

  end

end
