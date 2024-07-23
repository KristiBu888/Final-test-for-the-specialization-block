import Human_friends_package.Human_friends;
import Human_friends_package.Pack_animals.*;
import Human_friends_package.Pets.*;
import java.util.InputMismatchException;
import java.util.Scanner;

public class Menu {
    private final Database database;
    private final Scanner scanner;

    public Menu(Database database) {
        this.database = database;
        scanner = new Scanner(System.in);
    }

    public void display_menu() {
        while (true) {
            try {
                System.out.println("Меню:");
                System.out.println("1. Добавить новое животное");
                System.out.println("2. Показать список всех животных");
                System.out.println("3. Просмотреть список команд животного");
                System.out.println("4. Обучить животное новой команде");
                System.out.println("0. Выход");
                System.out.print("Выберите пункт меню: ");
                int choice = scanner.nextInt();
                scanner.nextLine();

                switch (choice) {
                    case 1 -> add_new_human_friends();
                    case 2 -> database.display_all_human_friends();
                    case 3 -> display_human_friends_commands();
                    case 4 -> learning_new_command();
                    case 0 -> {
                        System.out.println("Программа завершена.");
                        return;
                    }
                    default -> System.out.println("Неверный выбор. Попробуйте снова.");
                }
            } catch (InputMismatchException e) {
                System.out.println("Ошибка: неверный формат ввода. Попробуйте снова.");
                scanner.nextLine(); // Очистка буфера сканера после ошибочного ввода
            }
        }
    }

    private void add_new_human_friends() {
        System.out.println("Введите имя животного:");
        String name = scanner.nextLine();
        System.out.println("Введите список команд через запятую:");
        String commands = scanner.nextLine();

        System.out.println("Выберите класс животного:");
        System.out.println("1. Собака");
        System.out.println("2. Кошка");
        System.out.println("3. Хомяк");
        System.out.println("4. Осёл");
        System.out.println("5. Конь");
        int human_friend_class = scanner.nextInt();
        scanner.nextLine();

        Human_friends human_friend;
        switch (human_friend_class) {
            case 1 -> human_friend = new Dogs(name, commands);
            case 2 -> human_friend = new Cats(name, commands);
            case 3 -> human_friend = new Hamsters(name, commands);
            case 4 -> human_friend = new Donkeys(name, commands);
            case 5 -> human_friend = new Horses(name, commands);
            default -> {
                System.out.println("Неверный выбор класса животного.");
                return;
            }
        }

        database.add_human_friends(human_friend);
        System.out.println("Животное успешно добавлено в базу данных.");
    }

    private void display_human_friends_commands() {
        System.out.println("Введите имя животного:");
        String name = scanner.nextLine();

        database.display_human_friends_commands(name);
    }

    private void learning_new_command() {
        System.out.println("Введите имя животного:");
        String name = scanner.nextLine();
        System.out.println("Введите новые команды через запятую:");
        String command = scanner.nextLine();

        database.learning_new_command(name, command);
        System.out.println("Команда успешно добавлена для животного.");
    }
}