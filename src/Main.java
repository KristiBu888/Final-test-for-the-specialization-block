public class Main {
    public static void main(String[] args) throws Exception {
        Database database = new Database();
        Menu menu = new Menu(database);
        menu.display_menu();
    }
}