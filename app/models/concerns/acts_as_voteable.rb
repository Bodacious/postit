module ActsAsVoteable
  
  def self.included(base)
    base.class_eval do
      has_many :votes, as: :voteable
      
      scope :most_voted, -> {
        select("*, (SELECT count(votes.id) FROM votes 
          WHERE voteable_type='#{name}' AND 
          voteable_id = #{table_name}.id) AS 
          votes_count").order('votes_count DESC')
      }
    end
  end
  
  def total_votes
    up_votes - down_votes
  end
  
  def up_votes
    self.votes.up.size
  end
  
  def down_votes
    self.votes.down.size
  end
  
end