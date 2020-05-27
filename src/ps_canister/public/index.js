import ps_canister from 'ic:canisters/ps_canister';
import "nes.css/css/nes.min.css";
import "./styles.css";
import { main } from '../frontend/output/Main/index.js';

var link = document.createElement('link');
link.setAttribute('rel', 'stylesheet');
link.setAttribute('type', 'text/css');
link.setAttribute('href', 'https://fonts.googleapis.com/css?family=Press+Start+2P');
document.head.appendChild(link);

main(ps_canister);
