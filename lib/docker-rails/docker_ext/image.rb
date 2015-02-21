module Docker
  
  class Image
  
    def self.find_by_tag(tag)
      images = []
      Docker::Image.all.each do |image|
        if image.info["RepoTags"].include?(tag)
          images.push(image)
        end
      end
      images
    end
    
    def self.find_one_by_tag(tag)
      find_by_tag(tag).first
    end

  end
  
end
