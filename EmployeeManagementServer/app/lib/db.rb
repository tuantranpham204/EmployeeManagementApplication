class Db
  def self.query(sql, binds)
    conn = ActiveRecord::Base.connection
    if binds.any?
      res = conn.exec_query(sql, 'Native Query', binds)
    else
      res = conn.exec_query(sql, 'Native Query', binds)
    end
    res.to_a
  end
rescue ActiveRecord::StatementInvalid => e
  Rails.logger.error("DB Error: #{e.message} \n SQL: #{sql}")
  raise e
end
