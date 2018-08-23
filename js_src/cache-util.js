function fetchIntoCache(url, cacheMap, mapId){
    if(cacheMap.has(mapId)){
        return new Promise((resolve)=>{
            resolve(cacheMap.get(mapId));
        });
    }
    return fetch(url).then((res)=>{
        return res.json();
    }).then((json)=>{
        const data = json.data;
        cacheMap.set(mapId, data);
        return data;
    });
}



export default {
    fetchIntoCache,
};