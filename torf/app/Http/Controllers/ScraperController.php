<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Goutte\Client;

class ScraperController extends Controller
{
    private $results= array();
    public function scraper(){
        $client = new Client();
        $url = 'https://www.torfs.be/nl/home';
        $page = $client -> request('GET', $url);

       // echo "<pre>";
       // print_r($page);

        //$scrapedData= $page->filter('.title')->text();

        $page->filter('.title')->each(function ($item) use (&$results) {
            $results[] = $item->text();
        });


     //  $page->filter('.pdp-links')->each(function($item){
     //      $item->results[$item->filter('a')->text()] = $item->filter('.experience-component')->text();

     //  });

        return response()->json(['results' => $results]);
       // return view('scraper');
    }
}
