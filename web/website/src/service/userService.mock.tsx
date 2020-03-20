import { CreateUserRequest, CreateUserResponse } from "./userService";
import { sleepRandom } from "util/sleep";
import { userService as real } from './userService';

export const userService: typeof real = {
    async createUser(req: CreateUserRequest): Promise<CreateUserResponse> {
        await sleepRandom();
        if (Math.random() > 0.5) {
            return { type: 'Ok' }
        } else if (Math.random() > 0.5) {
            return { type: 'UsernameTaken' };
        } else {
            return { type: 'InvalidCaptchaCode' };
        }
    }
}