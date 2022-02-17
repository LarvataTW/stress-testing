import http from 'k6/http';
import { htmlReport } from "/data/lib/bundle.js";

export let options = {
  discardResponseBodies: true,
  scenarios: {
    contacts: {
      executor: 'ramping-vus',
      startVUs: 0,
      stages: [
        { duration: '1s', target: 10 },
      ],
      gracefulRampDown: '0s',
    },
  },
};

export default function () {
  http.get('domain');
}

export function handleSummary(data) {
  var now = Date.now();
  return htmlReport(data, { filename: now.toString().concat(`_all-10.js.html`) })
}
