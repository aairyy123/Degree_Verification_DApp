
import { describe, expect, it } from "vitest";
import { ClarityBin } from '@clarigen/core';
import { simnet } from './simnet'; // You'll need to create this
const accounts = simnet.getAccounts();
const address1 = accounts.get("wallet_1")!;

/*
  The test below is an example. To learn more, read the testing documentation here:
  https://docs.hiro.so/stacks/clarinet-js-sdk
*/

describe("example tests", () => {
  it("ensures simnet is well initialised", () => {
    expect(simnet.blockHeight).toBeDefined();
  });

  // it("shows an example", () => {
  //   const { result } = simnet.callReadOnlyFn("counter", "get-counter", [], address1);
  //   expect(result).toBeUint(0);
  // });
});
describe('Degree Verification Contract', () => {
  beforeAll(async () => {
    // Initialize simnet if needed
  });

  test('should add degree', async () => {
    const result = await simnet.call('add-degree', [...params]);
    expect(result).toBeTruthy();
  });
});
