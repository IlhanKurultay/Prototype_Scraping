<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Goutte\Client;

class ScraperController extends Controller
{
    private $results= array();
    public function scraper(){
        $client = new Client();
        $url = 'https://www.torfs.be/nl/heren/';
        $page = $client -> request('GET', $url);
        $results = [];
        $imageSources = [];
       // echo "<pre>";
       // print_r($page);

        //$scrapedData= $page->filter('.title')->text();
     //   $results = $page->filter('.product-tile')->each(function ($item) {
     //       return $item->text();
     //   });

        $imageSources = $page->filter('img')->each(function ($image) {
            $src = $image->attr('src');
            if (str_starts_with($src, 'https')) {
                return $src;
            }
        });


     //   $results['filter1'] = array_filter($results['filter1']);
       // $results['image_src'] = array_values(array_filter($results['image_src']));
     //  $page->filter('.pdp-links')->each(function($item){
     //      $item->results[$item->filter('a')->text()] = $item->filter('.experience-component')->text();

     //  });

     //  return response()->json(['results' => $results]);
        $imageSources = array_values(array_filter($imageSources));

        return response()->json(['image_src' => $imageSources]);
       // return view('scraper');
    }
}
