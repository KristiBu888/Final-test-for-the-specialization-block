package Human_friends_package.Pets;

import Human_friends_package.Human_friends;

public class Cats extends Human_friends {
    public Cats(String name, String commands) {
        super(name, commands);
    }

    @Override
    public void display_human_friends_commands() {
        System.out.println("Команды для кошки " + get_commands() + ": " + get_commands());
    }

    @Override
    public void learning_new_command(String command) {
        String updated_commands = get_commands() + "," + command;
        set_commands(updated_commands);
        System.out.println("Кошка " + get_name() + " научилась новой команде: " + command);
    }
}
