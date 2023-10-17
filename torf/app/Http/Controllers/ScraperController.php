<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Goutte\Client;

class ScraperController extends Controller
{
    private $results = array();

    public function scraper()
    {
        $client = new Client();
        $url = 'https://www.torfs.be/nl/heren/';
        $page = $client->request('GET', $url);
        $results = [];
        $imageSources = [];

        $results = $page->filter('.product-tile')->each(function ($item) {
            return $item->text();
        });

        $imageSources = $page->filter('img')->each(function ($image) {
            $src = $image->attr('src');
            if ($src !== null && str_starts_with($src, 'https')) {
                return $src;
            }
        });

        // Filter out any null values from the $imageSources array
        $imageSources = array_filter($imageSources);

        // Merge the filtered array back into the original array
        $imageSources = array_merge($imageSources);

        return response()->json(['results' => $results, 'image_src' => $imageSources]);
    }
}
