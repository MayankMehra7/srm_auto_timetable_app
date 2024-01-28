'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"OneSignalSDKWorker.js": "bb342b01d13bebb317c67b881692efd3",
"main.dart.js": "bd1671be4f458facd60df413625d742e",
"favicon.png": "79de1995b08723638f1ff2d170cd15be",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"assets/fonts/MaterialIcons-Regular.otf": "21743ba842a11c94b0da3947ac41a017",
"assets/json/1_mca_b.json": "91534783ed555e201751309e04518eb6",
"assets/json/3_bca_ds.json": "82f7ba02e4e2f05dc9fb420589658a52",
"assets/json/1_mca_g.json": "652550c51fe4811aedbd1df64d99f0bb",
"assets/json/1_mca_e.json": "3e20b7420f8da8f67ad374c3da81bd51",
"assets/json/1_bca_ds_c.json": "78ca792d461b7a1a2e1aaa5c0fc16013",
"assets/json/1_bca_b.json": "82f7ba02e4e2f05dc9fb420589658a52",
"assets/json/1_mca_c.json": "d659830d246873757292ca8c7478301c",
"assets/json/1_msc_ads_a.json": "8bee05f0f859f987a808b87f5866ca4c",
"assets/json/1_bca_ds_a.json": "82f7ba02e4e2f05dc9fb420589658a52",
"assets/json/1_mca_d.json": "0e48b96eac1176cb37d02ce8eaaf122e",
"assets/json/1_bca_ds_b.json": "82f7ba02e4e2f05dc9fb420589658a52",
"assets/json/2_bca_b.json": "d3fd9192c7ab8bc72d5858bbfd35c55d",
"assets/json/1_bca_a.json": "82f7ba02e4e2f05dc9fb420589658a52",
"assets/json/1_bca_c.json": "82f7ba02e4e2f05dc9fb420589658a52",
"assets/json/2_bca_c.json": "b2110db448e8fa8c2c7217a41cb011c1",
"assets/json/1_msc_ads_b.json": "ea1bfefc9fba1760911414b7269fe538",
"assets/json/3_bca_b.json": "711417531eaf20c5408713ff9201d3c9",
"assets/json/2_bca_ds.json": "93453d4dbc867d6532df665b160bbe77",
"assets/json/3_bca_a.json": "556b8e6908ea6936bc5a5efeb1719ba8",
"assets/json/1_mca_f.json": "9dda22c55182f05c6dc75f3513653651",
"assets/json/day_order.json": "0808e147ff597bb95405596740245885",
"assets/json/1_msc_ads_c.json": "4e7237474e18413b949b5a1963b01bf2",
"assets/json/1_mca_a.json": "2c39fb1b60e9766c6844b6131879c3f8",
"assets/json/1_msc_ads_d.json": "e276b86ed52cfac9f20f143465eea9b6",
"assets/json/2_bca_a.json": "44b9bd312d700443de253be408e97cd5",
"assets/AssetManifest.bin": "7f2b60a43a789e1199f6eee4a1f7bfaf",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/assets/images/auth.png": "fa5abd3fa2c41c603f2772bf36da5f7b",
"assets/assets/images/google.png": "ca2f7db280e9c773e341589a81c15082",
"assets/assets/icons/ig.png": "430b00e24570b7b07d1d3f9bebbf067a",
"assets/assets/icons/fb.png": "9473e230905f21e906807d56f468062a",
"assets/assets/icons/lw_dark.png": "e1d33854cf59a18c40be7711f2e9cebd",
"assets/assets/icons/twt.png": "9a1eb7e7d3f9a519fae1cbd5963336cf",
"assets/assets/icons/github_round.png": "4ac5b777b9436d7e783f18ad0260acdc",
"assets/assets/icons/lw_light.png": "4e42ecca60252ffb8484ff5bd8506ed2",
"assets/assets/icons/github.png": "2ef9f587f67e04fbfa7ef221cf0dde56",
"assets/AssetManifest.bin.json": "64f4ccbad51274eec71f712025d58dd2",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.json": "ad5d929d855144cec55feed5a24e07bd",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/NOTICES": "8b80a7d0042390b73e6d56dfa19df5e5",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"icons/Icon-512.png": "2b8ef5c88f9cd5c2e043f423c3239e0f",
"icons/Icon-maskable-192.png": "1c74f158cf44dfa46ff39cedd2d920fd",
"icons/Icon-192.png": "1c74f158cf44dfa46ff39cedd2d920fd",
"icons/Icon-maskable-512.png": "2b8ef5c88f9cd5c2e043f423c3239e0f",
"index.html": "4b5ee45b06a31955cd1034c67aa77fab",
"/": "4b5ee45b06a31955cd1034c67aa77fab",
"version.json": "780e2f95206aca3ffde73fd0d3f58e99",
"manifest.json": "da8d4e15db0a6db5d524bdb77c166c28"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
