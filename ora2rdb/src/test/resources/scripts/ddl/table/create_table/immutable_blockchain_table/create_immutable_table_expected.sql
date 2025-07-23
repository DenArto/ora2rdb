/*CREATE [-unconvertible RS-243359 IMMUTABLE] TABLE immutable_transactions (
    transaction_id NUMERIC(34, 8) GENERATED ALWAYS AS IDENTITY,
    amount NUMERIC(10,2),
    description VARCHAR(100)
) [-unconvertible RS-243359 NO DROP UNTIL 1 DAYS IDLE
  NO DELETE UNTIL 16 DAYS AFTER INSERT];*/