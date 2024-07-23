import Human_friends_package.*;
import Human_friends_package.Pack_animals.*;
import Human_friends_package.Pets.*;
import java.io.*;
import java.util.*;

public class Database {
    private final List<Human_friends> human_friends;
    private static final String FILE_PATH = "D:\\important\\website_developer\\developer\\final work on specialization\\app_animal_registry\\app_animal_registry\\all_animals.txt";

    public Database() {
        human_friends = new ArrayList<>();
        load_database();
    }

    public void add_human_friends(Human_friends human_friend) {
        human_friends.add(human_friend);
        save_database();
    }

    public void display_human_friends_commands(String name) {
        for (Human_friends human_friend : human_friends) {
            if (human_friend.get_name().equals(name)) {
                human_friend.display_human_friends_commands();
                return;
            }
        }
        System.out.println("Животное с именем " + name + " не найдено.");
    }

    public void learning_new_command(String name, String command) {
        for (Human_friends human_friend : human_friends) {
            if (human_friend.get_name().equals(name)) {
                String[] commands = command.split(",");
                for (int i = 0; i < commands.length; i++) {
                    String trimmed_command = commands[i].trim();
                    commands[i] = trimmed_command;
                }
                human_friend.learning_new_command(command);
                save_database();
                System.out.println("Команда успешно добавлена для животного.");
                return;
            }
        }
        System.out.println("Животное с именем " + name + " не найдено.");
    }

    private void load_database() {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 3) {
                    String class_name = data[0];
                    String name = data[1];
                    String commands = String.join(",", Arrays.copyOfRange(data, 2, data.length));

                    Human_friends human_friend;
                    switch (class_name) {
                        case "Cats" -> human_friend = new Cats(name, commands);
                        case "Dogs" -> human_friend = new Dogs(name, commands);
                        case "Donkeys" -> human_friend = new Donkeys(name, commands);
                        case "Hamsters" -> human_friend = new Hamsters(name, commands);
                        case "Horses" -> human_friend = new Horses(name, commands);
                        default -> {
                            System.out.println("Неизвестный класс животного: " + class_name);
                            continue;
                        }
                    }
                    human_friends.add(human_friend);
                } else {
                    System.out.println("Некорректные данные в файле: " + line);
                }
            }
            System.out.println("База данных успешно загружена.");
        } catch (IOException e) {
            System.out.println("Ошибка при чтении базы данных: " + e.getMessage());
        }
    }

    public void display_all_human_friends() {
        try {
            File file = new File(FILE_PATH);
            try (Scanner fileScanner = new Scanner(file)) {
                while (fileScanner.hasNextLine()) {
                    String human_friends_data = fileScanner.nextLine();
                    System.out.println(human_friends_data);
                }
            }
        } catch (FileNotFoundException e) {
            System.out.println("Файл с данными о животных не найден.");
        }
    }

    private void save_database() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Human_friends human_friend : human_friends) {
                String class_name = human_friend.getClass().getSimpleName();
                String name = human_friend.get_name();
                String commands = human_friend.get_commands().replaceAll(",\\s+", ",");

                String line = class_name + "," + name + "," + commands;
                writer.write(line);
                writer.newLine();
            }
            System.out.println("База данных успешно сохранена.");
        } catch (IOException e) {
            System.out.println("Ошибка при сохранении базы данных: " + e.getMessage());
        }
    }

}