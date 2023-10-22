const axios = require("axios");
const cheerio = require("cheerio");
const sqlite3 = require("sqlite3").verbose();

const url = "https://www.torfs.be/nl/heren/schoenen/sneakers/";
const db = new sqlite3.Database("scrapedData.db");
db.serialize(function () {
  db.run(
    "CREATE TABLE IF NOT EXISTS scraped_data (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category TEXT, price REAL)"
  );
});
async function fetchData() {
  try {
    const response = await axios.get(url);
    return response.data;
  } catch (error) {
    console.error("Error fetching data:", error);
  }
}
async function scrapeAndSave() {
  const html = await fetchData();
  const $ = cheerio.load(html);
  $("div.product-tile__content").each((index, element) => {
    const name = $(element).find("div.pdp-link > a").text();
    const category = $(element).find(".pdp-link.brand a").text();
    const price = parseFloat(
      $(element)
        .find(".product-tile__price .price .price__sales  .value")
        .attr("content")
    );
    const stmt = db.prepare(
      "INSERT INTO scraped_data (name, category, price) VALUES (?, ?, ?)"
    );
    stmt.run(name, category, price);
    stmt.finalize();
  });
  console.log("Scraped data inserted into SQLite database");
  db.close();
  displayScrapedData();
}

function displayScrapedData() {
  const query = "SELECT name, category, price FROM scraped_data";

  db.all(query, (err, rows) => {
    if (err) {
      console.error("Error reading data from the database:", err);
      return;
    }

    console.log("Scraped Data:");
    rows.forEach((row, index) => {
      console.log(`#${index + 1}`);
      console.log(`Name: ${row.name}`);
      console.log(`Category: ${row.category}`);
      console.log(`Price: ${row.price}`);
      console.log("------------");
    });
    db.close();
  });
}

scrapeAndSave();
