package config;

class NoValueProperty extends Exception{
    public NoValueProperty(String key){
        super("There is no key named " + key + "." );
    }
}
