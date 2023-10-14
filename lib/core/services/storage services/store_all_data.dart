import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
/*'''
        SELECT productsview.*, 1 as favorite,(products_price - (products_price*products_discount/100)) as products_price_discount FROM productsview 
INNER JOIN favorite ON favorite.favorite_productsid=productsview.products_id AND favorite.favorite_usersid='$userId' 
WHERE categories_id='$categoriesId'
UNION ALL 
SELECT *, 0 as favorite,(products_price - (products_price*products_discount/100)) as products_price_discount FROM productsview 
WHERE categories_id='$categoriesId' AND products_id NOT IN (SELECT productsview.products_id FROM productsview 
INNER JOIN favorite ON favorite.favorite_productsid=productsview.products_id AND favorite.favorite_usersid='$userId')
    '''*/
class StoreAllData {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDb();
      return _db;
    } else {
      return _db;
    }
  }

  initializeDb({int newVersion = 1}) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'ecommerce_app.db');
    Database db = await openDatabase(path,
        onCreate: _onCreate, version: newVersion, onUpgrade: _onUpgrade);
    return db;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    // use INTEGER instead of int
    // use TEXT instead of varchar
    // use REAL instead of FLOAT

    batch.execute('''
CREATE TABLE categories (
  categories_id TEXT NOT NULL,
  categories_name TEXT NOT NULL,
  categories_name_ar TEXT NOT NULL,
  categories_image TEXT NOT NULL,
  categories_datetime TEXT NOT NULL DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now', 'localtime'))
)
''');
    batch.execute('''
CREATE TABLE products (
  products_id TEXT NOT NULL,
  products_name TEXT NOT NULL,
  products_name_ar TEXT NOT NULL,
  products_description TEXT NOT NULL,
  products_description_ar TEXT NOT NULL,
  products_image TEXT NOT NULL,
  products_count TEXT NOT NULL,
  products_active TEXT NOT NULL,
  products_price TEXT NOT NULL,
  products_discount TEXT NOT NULL,
  products_datetime TEXT NOT NULL,
  favorite TEXT NOT NULL,
  products_price_discount TEXT NOT NULL,
  products_categories TEXT NOT NULL,
  categories_id TEXT NOT NULL,
  categories_name TEXT NOT NULL,
  categories_name_ar TEXT NOT NULL,
  categories_image TEXT NOT NULL,
  categories_datetime TEXT NOT NULL DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now', 'localtime'))
)
''');

    batch.execute('''
CREATE TABLE users (
  users_id TEXT NOT NULL,
  users_name TEXT NOT NULL,
  users_email TEXT NOT NULL,
  users_phone TEXT NOT NULL,
  users_approve TEXT NOT NULL DEFAULT 0
)
''');
 batch.execute('''
CREATE TABLE address (
  address_id TEXT NOT NULL,
  address_usersid TEXT NOT NULL,
  address_city TEXT NOT NULL,
  address_street TEXT NOT NULL,
  address_name TEXT NOT NULL
)
''');
   batch.execute('''
CREATE TABLE notifications (
  notification_id TEXT NOT NULL,
  notification_title TEXT NOT NULL,
  notification_title_ar TEXT NOT NULL,
  notification_body TEXT NOT NULL,
  notification_body_ar TEXT NOT NULL,
  notification_datetime TEXT NOT NULL
)
''');
//     batch.execute('''
// CREATE OR REPLACE VIEW productsview as SELECT products.* , categories.* FROM products INNER JOIN categories ON categories.categories_id=products.products_categories;)
// ''');

    await batch.commit();
//     await db.execute('''
//   CREATE TABLE "notes" (
//     "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
//     "note" TEXT NOT NULL
//   )
//  ''');
    print(" onCreate =====================================");
  }

  readData(String table, {List<String>? columns, String? where}) async {
    Database? myDb = await db;
    List<Map> response =
        await myDb!.query(table, columns: columns, where: where);
    return response;
  }

  selectProductByCategory(String categoriesId) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery('''
      SELECT * FROM products WHERE categories_id='$categoriesId'
    ''');
    return response;
  }

  insertData(String table, Map<String, Object?> values) async {
    Database? myDb = await db;
    int response = await myDb!.insert(table, values);
    return response;
  }

  updateData(String table, Map<String, Object?> values, {String? where}) async {
    Database? myDb = await db;
    int response = await myDb!.update(table, values, where: where);
    return response;
  }

  deleteData(String table, {String? where}) async {
    Database? myDb = await db;
    int response = await myDb!.delete(table, where: where);
    return response;
  }

  deleteDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'ecommerce_app.db');
    deleteDatabase(path);
  }
// SELECT
// DELETE
// UPDATE
// INSERT
}
