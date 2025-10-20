'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "2f2cfb3f6d3ee35639dcdad5ef154094",
"assets/AssetManifest.bin.json": "124a5ab5b388e88b88e9719180053079",
"assets/AssetManifest.json": "5515e1e007d7031d88140e7e546bad01",
"assets/assets/images/akar%2520kelapa.jpeg": "89f686c59c9992ba644ec7dac7608ff5",
"assets/assets/images/Apem.jpeg": "2a30347078f3dae63c00c161e8723fb4",
"assets/assets/images/bawang.jpeg": "b54685ad2c5e21b40ca8fc2c374ecf59",
"assets/assets/images/black%2520forest.jpeg": "d70cd4ad379cab36df0c6ffbc5091136",
"assets/assets/images/brownis.jpeg": "a4c2554f6e32bcfc421d32debcf206be",
"assets/assets/images/cheescake.jpeg": "56953084eaa57b4c6cf4482140b6b8c7",
"assets/assets/images/chip%2520cookies.jpeg": "596619a43bb71d57ab28d142e033b36e",
"assets/assets/images/cloud%2520coklat.jpeg": "0d526c59d3c39ef430e6301a5d301e10",
"assets/assets/images/cup%2520cake.jpeg": "579c09ab08f7d08e51f2f9a78e95f586",
"assets/assets/images/dadar%2520gulung.jpeg": "56b75aeccc1e54977d0bdffd746342b8",
"assets/assets/images/kastengel.jpeg": "965ec5e65df638912c3c3d88ff68f0e6",
"assets/assets/images/klepon.jpeg": "29a361e3dcbd66393727ee4502c01bfd",
"assets/assets/images/kue%2520kacang.jpeg": "cd8ac019a9ab23d66b4b21aa362e8905",
"assets/assets/images/kue%2520lapis.jpeg": "05ec57d6a6e848e2479baf5c982b590a",
"assets/assets/images/kue%2520pie.jpeg": "8fe8b096470c517c5c04b05c92e49c2e",
"assets/assets/images/kue%2520putu.jpeg": "1487ce2da39becd879472aad0c142619",
"assets/assets/images/kue%2520sagu.jpeg": "ba6565bb159e62897f1fa84c311f76d6",
"assets/assets/images/kue_bg.jpeg": "4d34b37d635ee72ada50867328371a3b",
"assets/assets/images/lemper.jpeg": "26ceaafd16e31e5ae72eb986995c63d2",
"assets/assets/images/lidah%2520kucing.jpeg": "c43e53db6dee623e89c854f477f4b990",
"assets/assets/images/logo.png": "c4eb81fa35268541179b56f4fbd3bc6b",
"assets/assets/images/logosplash.png": "1b314ed2d6a75f2e94115a4eb225461a",
"assets/assets/images/LUPIS%2520KETAN%2520PANDAN.jpeg": "49181a37e8b242b97b6b67c91ae9166f",
"assets/assets/images/nagasari%2520pisang.jpeg": "c73401877375dcd63c68f158c47cbdc7",
"assets/assets/images/nastar.jpeg": "e7151b9ed6876bc21e97dc6abd41818c",
"assets/assets/images/onde-onde.jpeg": "f77665289a58bad41bbfc3e82471e81d",
"assets/assets/images/profil.jpeg": "1b52fd4e391811ad37e6fcedbe9e0ce5",
"assets/assets/images/promosi.jpeg": "25122566b2ff48cdc24dcbee56dd6993",
"assets/assets/images/pukis.jpeg": "9f8b09704d833ce657d4ec0f7ffcdc33",
"assets/assets/images/putri%2520salju.jpeg": "b59e5b8edb79c4f3ae827a347b309b87",
"assets/assets/images/putu%2520ayu.jpeg": "d1e6ea95e33b52e9803ff1106668d408",
"assets/assets/images/rainbow%2520cake.jpeg": "5c7c7553dcd2469b2c8eba1eca65d4ae",
"assets/assets/images/Red%2520Velvet%2520Cake.jpeg": "ee6ef5cbf05b16e404215abafd2eb24a",
"assets/assets/images/Semprit.jpeg": "84fe0a2294b4a51fac827a8cc5c78c5e",
"assets/assets/images/sponge%2520cake.jpeg": "549ab7146bb5dabd616f38a017b7cf57",
"assets/assets/images/Tiramisu%2520cake.jpeg": "fd94a01f2c335881afe92bfff52bf024",
"assets/FontManifest.json": "97c2528ecc2fbf4093965257fdba1854",
"assets/fonts/MaterialIcons-Regular.otf": "62f30ad52ea1d406930b765fa2c20e61",
"assets/NOTICES": "5238f086d3a9b04a2a191d373dfe7d20",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Brands-Regular-400.otf": "b08c87f45577bfeda4dd4490dbc8f681",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Free-Regular-400.otf": "df86a1976d76bd04cf3fcaf5add2dd0f",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Free-Solid-900.otf": "e151d7a6f42f17e9ea335c91d07b3739",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "22e67ef2fd28bb25aadaf17d547f211e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "e608f7d71db0a8dcc8eaa0286a638bd1",
"/": "e608f7d71db0a8dcc8eaa0286a638bd1",
"main.dart.js": "e84b691221804ec4defdd6663150af8e",
"manifest.json": "bf24c84c3bf99672a631c4f84464e793",
"splash/img/dark-1x.jpeg": "f7f3a23cf31088462f0636d12ffa09dd",
"splash/img/dark-2x.jpeg": "f7f3a23cf31088462f0636d12ffa09dd",
"splash/img/dark-3x.jpeg": "f7f3a23cf31088462f0636d12ffa09dd",
"splash/img/dark-4x.jpeg": "f7f3a23cf31088462f0636d12ffa09dd",
"splash/img/light-1x.jpeg": "f7f3a23cf31088462f0636d12ffa09dd",
"splash/img/light-2x.jpeg": "f7f3a23cf31088462f0636d12ffa09dd",
"splash/img/light-3x.jpeg": "f7f3a23cf31088462f0636d12ffa09dd",
"splash/img/light-4x.jpeg": "f7f3a23cf31088462f0636d12ffa09dd",
"version.json": "15235b5108d6a877ef74fe3317a96bf7"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
