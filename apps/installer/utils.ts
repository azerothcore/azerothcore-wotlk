import * as path from "https://deno.land/std/path/mod.ts";
import makeloc from "https://deno.land/x/dirname@1.1.2/mod.ts";

const { __dirname } = makeloc(import.meta);

// specify the needed paths here
const ACORE_JSON = path.resolve(__dirname + "/../../acore.json");

export async function getAcoreReleaseVersion() {
  // read the acore.json file to work with the versioning
  const decoder = new TextDecoder("utf-8");
  //console.debug(`Open ${ACORE_JSON}`)
  const data = await Deno.readFile(ACORE_JSON);
  const acoreInfo = JSON.parse(decoder.decode(data));

  return `AzerothCore Rev. ${acoreInfo.version}`;
}
