import { sleepRandom } from "util/sleep";
import Axios from 'axios';

export interface CreateUserRequest {
    username: string;
    password: string;
    reCaptchaKey: string;
}

export type CreateUserResponse =
    { type: 'Ok' } |
    { type: 'UsernameTaken' } |
    { type: 'InvalidCaptchaCode' } 

export const userService = {
    async createUser(req: CreateUserRequest): Promise<CreateUserResponse> {
        const resp = await Axios.post('/api/users', req);
        return resp.data;
    }
}