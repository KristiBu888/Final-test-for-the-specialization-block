package Human_friends_package;

public abstract class Human_friends {
    private final String name;
    private String commands;

    public Human_friends(String name, String commands) {
        this.name = name;
        this.commands = commands;
    }

    public String get_name() {
        return name;
    }

    public String get_commands() {
        return commands;
    }

    public void set_commands(String updated_commands) {
        this.commands = updated_commands;
    }

    public abstract void display_human_friends_commands();

    public abstract void learning_new_command(String command);
}
