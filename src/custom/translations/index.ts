import { en } from '../../translations/en';
import { zh } from './zh';

// tslint:disable:no-submodule-imports
import localeZh from 'react-intl/locale-data/zh';
// tslint:enable

export const customLocaleData = ([...localeZh]);

export type LangType = typeof en;

export const customLanguageMap = {
    zh,
};
