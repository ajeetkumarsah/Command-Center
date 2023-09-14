'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "723c6c2d2f9d8da6c5c27bea79ebaa34",
"index.html": "b6b79f10d266e8f2d558bf352b6522b3",
"/": "b6b79f10d266e8f2d558bf352b6522b3",
"main.dart.js": "56ed360da734c4b1d81f189c4b1987f8",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "05b9dac7638eeedd95777835dfd33d11",
"assets/AssetManifest.json": "f25246379e9d33d0c0a769e9fa652d6b",
"assets/NOTICES": "da89fa93c35df3bdba0db92e6c6c7607",
"assets/FontManifest.json": "76812e246184d6cad25a7055367c6935",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "0ed499d30c2fcb8059cdbeeea9053f00",
"assets/fonts/MaterialIcons-Regular.otf": "3999993950cf35315ed374c01d1d4adf",
"assets/assets/images/svg/image65.png": "aeafc8b1c91a308268716c1b2b6dd16d",
"assets/assets/images/svg/image6.svg": "0e5247eeb6915b6dc5574257101fb0a3",
"assets/assets/images/map.png": "082d75afc5dedd123b5fd53c978fd2d7",
"assets/assets/images/vector.png": "84783c36862bcc277144c0577c82dbc2",
"assets/assets/images/app_bar/group9.png": "ac827634fa08fdfd60fa718f835ac430",
"assets/assets/images/app_bar/vectorselect.png": "5fca618f6c4e2811803266a9b2c9a433",
"assets/assets/images/app_bar/EE72.png": "4fe3bb946749d3c14ca02f29ce18ac0d",
"assets/assets/images/app_bar/masklogin.png": "9d60dcd2fface1ca3ce08c38acb25620",
"assets/assets/images/app_bar/EE73.png": "9c4b098fefcc29c6f1918493fae4e965",
"assets/assets/images/app_bar/maskgroup.png": "dd989d48a63b81ab6135d8573e0c1cf2",
"assets/assets/images/app_bar/group.png": "4933ddf9ca99bd72bd4799c11528da31",
"assets/assets/images/app_bar/pgswatch1.png": "792da14bf956e08168719400b3fe68cd",
"assets/assets/images/app_bar/EE74.png": "18fd3c4dac174c95706bef0601df7a0e",
"assets/assets/images/app_bar/rectangle7.png": "2d2c04ddef0f11dd073f2c2679acaffa",
"assets/assets/images/app_bar/vector.png": "503ca112da4384c56bf44fe016d72081",
"assets/assets/images/app_bar/vectordeselect.png": "5d7a80ba8a9fec138a8d4d84ba0eea63",
"assets/assets/images/app_bar/homebackground.png": "f1a50d1630143e85a090cc5adf5c168d",
"assets/assets/images/app_bar/background.png": "e8006e07701429544ee484f1b68c5d9e",
"assets/assets/images/app_bar/header.png": "8b1ee66a2b174ba70ad61492f2a0ce01",
"assets/assets/images/app_bar/E75.png": "f22cc970e904ba8fc97bee1bdfc69339",
"assets/assets/images/app_bar/E72.png": "d1d399de06d6582f974b5129bcebe918",
"assets/assets/images/app_bar/E73.png": "868b3c8af284777a7357515c6306d2ab",
"assets/assets/images/app_bar/swatch.png": "792da14bf956e08168719400b3fe68cd",
"assets/assets/images/app_bar/artwork.png": "a59ade922fce95fa1684ea4773ac3482",
"assets/assets/images/app_bar/rec.png": "9ead4e23076d8e42f2257aafabaefb52",
"assets/assets/images/app_bar/rec383.png": "656360da6b2e7a00cd4876ae1ea42938",
"assets/assets/images/app_bar/default.png": "d49b5350efc472c6433b82dff9625df6",
"assets/assets/images/app_bar/back.png": "57f5ba68236edf97b9dd81fbf6df61c0",
"assets/assets/images/app_bar/rec384.png": "d9fdd7a16a668bc2618926787fa822a4",
"assets/assets/images/iconartwork.png": "e28965e89c9e0c89c1b2555238d659e6",
"assets/assets/images/image.png": "6646bf3fb62c65d89268f0b1bd7967c1",
"assets/assets/json/splashbglottie.json": "49e832c31034f75238cd20c4f977bfdc",
"assets/assets/icon/icon.png": "5f6c2ac1bb5eb107075ad892c7452e12",
"assets/assets/icon/arrow_left.png": "6512ee12439e05eaa2119e3540aeb398",
"assets/assets/icon/profile.png": "ba4e037e1b9676c5215541748eaa1e42",
"assets/assets/icon/pingid.png": "a11c8b6763f8d2d64179ead5e0a9a6e7",
"assets/assets/fonts/product-sans/Product%2520Sans%2520Bold.ttf": "dba0c688b8d5ee09a1e214aebd5d25e4",
"assets/assets/fonts/product-sans/Product%2520Sans%2520Italic.ttf": "e88ec18827526928e71407a24937825a",
"assets/assets/fonts/product-sans/Product%2520Sans%2520Bold%2520Italic.ttf": "79750b1d82b2558801373d62dd7e5280",
"assets/assets/fonts/product-sans/Product%2520Sans%2520Regular.ttf": "eae9c18cee82a8a1a52e654911f8fe83",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
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
