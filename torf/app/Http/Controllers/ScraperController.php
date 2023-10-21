<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Goutte\Client;

class ScraperController extends Controller
{
    private $results= array();
    public function scraper()
    {
        $client = new Client();
        $url = 'https://www.torfs.be/nl/heren/schoenen/boots/';
        $page = $client->request('GET', $url);
        $titles = [];
        $categories = [];
        $price = [];
        $imageSources = [];

        $titles = $page->filter('.pdp-link[itemprop="name"]')->each(function ($item) {
            return $item->text();
        });
        $categories = $page->filter('.brand')->each(function ($item) {
            return $item->text();
        });
        $price = $page->filter('.price')->each(function ($item) {
            return $item->text();
        });
        $imageSources = $page->filter('.tile-image')->each(function ($image) {
            $src = $image->attr('src');
            if ($src !== null && str_starts_with($src, 'https')) {
                return $src;
            }
            return '';
        });

        // Filter out any null values from the $imageSources array
        $imageSources = array_values(array_filter($imageSources));

        return response()->json(['results' => $titles,'categories'=>$categories,'price'=>$price, 'image_src' => $imageSources]);
    }
    }
