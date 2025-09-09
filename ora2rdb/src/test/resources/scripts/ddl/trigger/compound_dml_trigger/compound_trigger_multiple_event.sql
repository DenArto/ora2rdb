 CREATE TRIGGER compounder FOR
   UPDATE OR INSERT OR DELETE
   ON incremented_values
   COMPOUND TRIGGER
    v_global_var   NUMBER := 1;
   BEFORE STATEMENT
   IS
   BEGIN
      v_global_var := v_global_var + 1;
   END
   BEFORE STATEMENT;
   BEFORE EACH ROW
   IS
   BEGIN
      v_global_var := v_global_var + 1;
   END
   BEFORE EACH ROW;
   AFTER EACH ROW
   IS
   BEGIN
      v_global_var := v_global_var + 1;
   END
   AFTER EACH ROW;
   AFTER STATEMENT
   IS
   BEGIN
      v_global_var := v_global_var + 1;
   END
   AFTER STATEMENT;
END;