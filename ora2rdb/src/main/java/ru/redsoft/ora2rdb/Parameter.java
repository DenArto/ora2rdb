package ru.redsoft.ora2rdb;

import java.util.Objects;

public class Parameter {


    private String name;
    private String type;
    private boolean out;

    public Parameter(){
        this.name = null;
        this.type = null;
        this.out = false;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public boolean isOut() {
        return out;
    }
    public void setOut(boolean out) {
        this.out = out;
    }

    public boolean equalParameter(Parameter parameter) {
        return (Objects.equals(parameter.getType(), this.getType()));
    }

    public boolean equalParameterWithTypeConversion(Parameter parameter) {
        if(TypeConversion.conversion_type.get(parameter.getType()) != null)
            return TypeConversion.conversion_type.get(parameter.getType()).contains(this.getType());
        else
            return (Objects.equals(parameter.getType(), this.getType()));
    }



}

