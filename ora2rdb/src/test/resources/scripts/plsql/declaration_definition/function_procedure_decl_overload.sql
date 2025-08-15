
    CREATE PROCEDURE Proc(Var IN NUMBER) IS
    BEGIN
        g_last_output := 'String processed: ' || Var;
    END procedure_overload;

    CREATE PROCEDURE procedure_overload(Var IN NUMBER) IS

    BEGIN
        g_last_output := 'String processed: ' || Var;
    END procedure_overload;

    CREATE PROCEDURE procedure_overload(Var IN VARCHAR2) IS

    BEGIN
        g_last_output := 'String processed: ' || Var;
    END base_p;

    CREATE FUNCTION func(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER IS
        v_result VARCHAR2(4000);
    BEGIN
        RETURN v_result;
    END func;

    CREATE FUNCTION function_overload(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER IS
        v_result VARCHAR2(4000);
    BEGIN
        RETURN v_result;
    END function_overload;

    CREATE FUNCTION function_overload(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER IS
        v_result VARCHAR2(4000);
    BEGIN
        RETURN v_result;
    END function_overload;




    CREATE PROCEDURE Out_Screen(Var IN NUMBER) IS

            PROCEDURE Out_Screen1(NM IN NUMBER);

            PROCEDURE Out_Screen(Var IN VARCHAR2);

            PROCEDURE Out_Screen(NM IN NUMBER);

            FUNCTION Add_One_Num1(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER;

            FUNCTION Add_One_Num(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER;

            FUNCTION Add_One_Num(M IN NUMBER, K IN VARCHAR2) RETURN VARCHAR;

            PROCEDURE base1(Var IN NUMBER) IS

            BEGIN
                g_last_output := 'String processed: ' || Var;
            END base1;

            PROCEDURE base_p(Var IN NUMBER) IS

            BEGIN
                g_last_output := 'String processed: ' || Var;
            END base_p;

            PROCEDURE base_p(Var IN VARCHAR2) IS

            BEGIN
                g_last_output := 'String processed: ' || Var;
            END base_p;

            FUNCTION base2(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER IS
                v_result VARCHAR2(4000);
            BEGIN
                RETURN v_result;
            END base2;

            FUNCTION base_f(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER IS
                v_result VARCHAR2(4000);
            BEGIN
                RETURN v_result;
            END base_f;

            FUNCTION base_f(M IN NUMBER, K IN VARCHAR2) RETURN VARCHAR2 IS
                v_result VARCHAR2(4000);
            BEGIN
                RETURN v_result;
            END base_f;
    BEGIN
        null;
    END Out_Screen;


    CREATE FUNCTION Add_One_Num(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER IS

            PROCEDURE Out_Screen1(NM IN NUMBER);

            PROCEDURE Out_Screen(Var IN VARCHAR2);

            PROCEDURE Out_Screen(NM IN NUMBER);

            FUNCTION Add_One_Num1(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER;

            FUNCTION Add_One_Num(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER;

            FUNCTION Add_One_Num(M IN NUMBER, K IN VARCHAR2) RETURN VARCHAR;

            PROCEDURE base1(Var IN NUMBER) IS

            BEGIN
                g_last_output := 'String processed: ' || Var;
            END Out_Screen;

            PROCEDURE base_p(Var IN NUMBER) IS

            BEGIN
                g_last_output := 'String processed: ' || Var;
            END Out_Screen;

            PROCEDURE base_p(Var IN VARCHAR2) IS

            BEGIN
                g_last_output := 'String processed: ' || Var;
            END base_p;

            FUNCTION base2(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER IS
                v_result VARCHAR2(4000);
            BEGIN
                RETURN v_result;
            END base2;

            FUNCTION base_f(NM IN NUMBER, BM IN NUMBER) RETURN NUMBER IS
                v_result VARCHAR2(4000);
            BEGIN
                RETURN v_result;
            END base_f;

            FUNCTION base_f(M IN NUMBER, K IN VARCHAR2) RETURN VARCHAR2 IS
                v_result VARCHAR2(4000);
            BEGIN
                RETURN v_result;
            END base_f;

            v_result VARCHAR2(4000);

    BEGIN
          RETURN v_result;
    END Add_One_Num;