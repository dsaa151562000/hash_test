class Blog < ApplicationRecord
  # attr_accessor :arry

  def merge_worker(blogs)
    arry = []
    blogs.each do |blog|
      blog_hash = blog.attributes
      blog_hash = blog_hash.symbolize_keys

      worker = Worker.find_by(blog_id: blog_hash[:id])

      if worker.present?
        full_name = worker.name
      else
        full_name = nil
      end
      blog_hash[:full_name] = full_name
      arry  << blog_hash
    end
    arry
  end
end
