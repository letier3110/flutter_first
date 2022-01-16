import { RequestSignPayloadInput, SigningType } from '@airgap/beacon-sdk';

const payload: RequestSignPayloadInput = {
  signingType: SigningType.MICHELINE,
  payload: "asdasdas",
};
const signedPayload = await wallet.client.requestSignPayload(payload);
const { signature } = signedPayload;