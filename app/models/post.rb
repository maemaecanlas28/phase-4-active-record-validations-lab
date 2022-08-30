class Post < ApplicationRecord

    # all posts have a title
    validates :title, presence: true

    # post content is at least 250 characters long
    validates :content, length: { minimum: 250 }

    # post summary is a maximum of 250 characters
    validates :summary, length: { maximum: 250 }

    # post category is either Fiction or Non-Fiction
    validates :category, inclusion: { in: %w(Fiction Non-Fiction)}

    validate :clickbait?

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
  ]

  def clickbait?
    if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
      errors.add(:title, "must be clickbait")
    end
  end

end
