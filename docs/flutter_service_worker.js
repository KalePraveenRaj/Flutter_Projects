'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e84a3f2bebea40a2ceaa9ae54adc0729",
"assets/AssetManifest.bin.json": "e955a32173da64768af8acb8e526d22e",
"assets/assets/logo.svg": "088ac1c2fda6b856ea264290726bf29a",
"assets/assets/Praveen_Raj_Resume.pdf": "6b369c0267c49dc2d2e486cff9a2a0c8",
"assets/assets/profile.jpg": "34e84da14fbc4f4c8fef6d35f0417f28",
"assets/assets/projects/deepSnap.jpg": "3dba1aae40ffbbe8e2abf20916bf163e",
"assets/assets/projects/floatingIcon.png": "853fb8e3a813870f4afd57c2fe7f66f9",
"assets/assets/projects/portfolio.JPG": "c0770cc7907b7faf7d37b61b178f8815",
"assets/assets/projects/swaggerOpenAPI.JPG": "c1ee646887a27bfd6b9916bb301559d3",
"assets/assets/skills/apachekafka.svg": "6214e8fe6424f122f85d885f90a01852",
"assets/assets/skills/aws.svg": "7e076a4cc498952276bf6c594781686e",
"assets/assets/skills/bootstrap.svg": "9c408633f37b9784f27c8b5cfc0f1e09",
"assets/assets/skills/css.svg": "2348e003fa97f1e2a6955aae79911a2c",
"assets/assets/skills/dart.svg": "f230da6e0aef73e4ee987011de564060",
"assets/assets/skills/docker.svg": "bacb90ebb9ed3f0930b1632fe159c4e9",
"assets/assets/skills/electron.svg": "a8696561a8d85b0578c8e0f20d450db6",
"assets/assets/skills/express.svg": "9cb40a9f0c7bec52ffa4252a2aab9551",
"assets/assets/skills/firebase.svg": "6e071f37c085cca59f19eb6d737061d4",
"assets/assets/skills/flutter.svg": "ea67ff4e8060634c0008c912a810338e",
"assets/assets/skills/git.svg": "877dcf2b9755734bc774073a5a2ecc3c",
"assets/assets/skills/github.svg": "8dc66f6f6f62dcd1661b79ac93910a05",
"assets/assets/skills/graphql.svg": "257bc0f6191a275df7ea73eb8e16d71c",
"assets/assets/skills/html5.svg": "60355ba2b28d03b4e5309a326de1bfde",
"assets/assets/skills/java.svg": "07f725f1add13fa03dc1470d04e1eb42",
"assets/assets/skills/javascript.svg": "50b1f12e766978b8b947c986193a175b",
"assets/assets/skills/kubernetes.svg": "6d7ca10a9229ca4e4f2c56607cd2003d",
"assets/assets/skills/mongodb.svg": "6212cfc762500f22443465de26bd690a",
"assets/assets/skills/mysql.svg": "863dfa17a3cdb94115c3b1204b98b164",
"assets/assets/skills/nextdotjs.svg": "0cfb6c22314de49545b96c57d34ff506",
"assets/assets/skills/nodedotjs.svg": "f216a4a331e174408defcde7ff8327d1",
"assets/assets/skills/python.svg": "76863e22804f3ff7ad5aa94ae007feee",
"assets/assets/skills/react.svg": "3e675f19f64550d4bb2cee2bcc298072",
"assets/assets/skills/redis.svg": "d4a5da62a7f803bf2df5edcd270222fa",
"assets/assets/skills/redux.svg": "489be6bf0a609752d075d2e89edde81c",
"assets/assets/skills/springboot.svg": "c85731828ae759e22048d3b936843b5a",
"assets/assets/skills/supabase.svg": "e60d6c450323efdcad8ba04dab4516b9",
"assets/assets/skills/tailwindcss.svg": "dc338044106a5d5d130b39d361641adf",
"assets/assets/skills/typescript.svg": "e82c7ff470fdf893e4f26b3ae003e511",
"assets/FontManifest.json": "c75f7af11fb9919e042ad2ee704db319",
"assets/fonts/MaterialIcons-Regular.otf": "0552e7d3741bb6d44623d0fd779411af",
"assets/NOTICES": "f50682270e2e14b0849f62b24e873037",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "794be6179667696963069d2eabeace7b",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "e45d3a26aeaa52551fc467b437db0f0b",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "116412ce7261b0bc1dcd28ad1226cfe8",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "9307f5f728686bcc74f0e1a9e354c049",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "d6ed41a34df7d6e9239e7ececd819783",
"/": "d6ed41a34df7d6e9239e7ececd819783",
"logo.ico": "7520783d7d54d0eab098f34ae66bc020",
"logo2.png": "e159f8fee96e2dd06fa0ea115eef9e99",
"main.dart.js": "6cd55ba2f29638a2a82502b5e2a68217",
"manifest.json": "bf24c84c3bf99672a631c4f84464e793",
"Praveen_Raj_Resume.pdf": "6b369c0267c49dc2d2e486cff9a2a0c8",
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
