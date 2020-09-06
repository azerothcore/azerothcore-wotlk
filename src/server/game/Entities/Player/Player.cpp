void Player::_LoadMailAsynch(PreparedQueryResult result)
{
    m_mail.clear();
    uint32 prevMailID = 0;
    Mail* m = nullptr;
    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            if (fields[14].GetUInt32() != prevMailID)
            {
                if (m)
                    m_mail.push_back(m);

                m = new Mail;

                m->messageID      = fields[14].GetUInt32();
                m->messageType    = fields[15].GetUInt8();
                m->sender         = fields[16].GetUInt32();
                m->receiver       = fields[17].GetUInt32();
                m->subject        = fields[18].GetString();
                m->body           = fields[19].GetString();
//                has_items         = fields[20].GetBool();
                m->expire_time    = time_t(fields[21].GetUInt32());
                m->deliver_time   = time_t(fields[22].GetUInt32());
                m->money          = fields[23].GetUInt32();
                m->COD            = fields[24].GetUInt32();
                m->checked        = fields[25].GetUInt8();
                m->stationery     = fields[26].GetUInt8();
                m->mailTemplateId = fields[27].GetInt16();

                if (m->mailTemplateId && !sMailTemplateStore.LookupEntry(m->mailTemplateId))
                {
                    sLog->outError("Player::_LoadMail - Mail (%u) have not existed MailTemplateId (%u), remove at load", m->messageID, m->mailTemplateId);
                    m->mailTemplateId = 0;
                }

                m->state = MAIL_STATE_UNCHANGED;
            }

            if (m && fields[20].GetBool() /*has_items*/ && fields[12].GetUInt32() /*itemEntry*/)
            {
                uint32 itemGuid = fields[11].GetUInt32();
                uint32 itemTemplate = fields[12].GetUInt32();

                m->AddItem(itemGuid, itemTemplate);

                ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemTemplate);

                if (!proto)
                {
                    sLog->outError("Player %u has unknown item_template (ProtoType) in mailed items(GUID: %u template: %u) in mail (%u), deleted.", GetGUIDLow(), itemGuid, itemTemplate, m->messageID);

                    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INVALID_MAIL_ITEM);
                    stmt->setUInt32(0, itemGuid);
                    CharacterDatabase.Execute(stmt);

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
                    stmt->setUInt32(0, itemGuid);
                    CharacterDatabase.Execute(stmt);
                    continue;
                }

                Item* item = NewItemOrBag(proto);

                if (!item->LoadFromDB(itemGuid, MAKE_NEW_GUID(fields[13].GetUInt32(), 0, HIGHGUID_PLAYER), fields, itemTemplate))
                {
                    sLog->outError("Player::_LoadMailedItems - Item in mail (%u) doesn't exist !!!! - item guid: %u, deleted from mail", m->messageID, itemGuid);

                    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM);
                    stmt->setUInt32(0, itemGuid);
                    CharacterDatabase.Execute(stmt);

                    item->FSetState(ITEM_REMOVED);

                    SQLTransaction temp = SQLTransaction(nullptr);
                    item->SaveToDB(temp);                               // it also deletes item object !
                    continue;
                }

                AddMItem(item);
            }

            prevMailID = fields[14].GetUInt32();
        }
        while (result->NextRow());

        m_mail.push_back(m);
    }
    // Xinef: this is stored during storage initialization
    sWorld->UpdateGlobalPlayerMails(GetGUIDLow(), m_mail.size(), false);
    m_mailsLoaded = true;
}
