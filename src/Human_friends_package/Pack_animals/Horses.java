package Human_friends_package.Pack_animals;

import Human_friends_package.Human_friends;

public class Horses extends Human_friends {
    public Horses(String name, String commands) {
        super(name, commands);
    }

    @Override
    public void display_human_friends_commands() {
        System.out.println("Список команд для коня:");
        System.out.println(get_commands());
    }

    @Override
    public void learning_new_command(String command) {
        String updated_commands = get_commands() + "," + command;
        set_commands(updated_commands);
    }
}