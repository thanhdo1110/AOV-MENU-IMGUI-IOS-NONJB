
bool AimSkill;
int Radius = 0;
bool AutoTrung;
int skillSlot;
bool aimSkill1;
bool aimSkill2;
bool aimSkill3;
float SetFieldOfView = 2.0;
static bool lockcam = false;
static bool AutoWinInGame = false;
static bool isPlayerName = false; 
static bool Map = false; 

//Aimbot

bool (*_IsSmartUse)(void *instance);
bool (*_get_IsUseCameraMoveWithIndicator)(void *instance);

bool IsSmartUse(void *instance){
    
    bool aim = false;
    
    if(skillSlot == 1 && aimSkill1){
        aim = true;
    }
    
    if(skillSlot == 2 && aimSkill2){
        aim = true;
    }
    
    if(skillSlot == 3 && aimSkill3){
        aim = true;
    }
    
    if(AutoTrung && aim){
        return true;
    }
    
    return _IsSmartUse(instance);
}


bool get_IsUseCameraMoveWithIndicator(void *instance){
    
    bool aim = false;
    
    if(skillSlot == 1 && aimSkill1){
        aim = true;
    }
    
    if(skillSlot == 2 && aimSkill2){
        aim = true;
    }
    
    if(skillSlot == 3 && aimSkill3){
        aim = true;
    }
    
    
    if(AutoTrung && aim){
        return true;
    }
    
    return _get_IsUseCameraMoveWithIndicator(instance);
}
void (*old_IsDistanceLowerEqualAsAttacker)(void *instance, int targetActor, int radius);
void IsDistanceLowerEqualAsAttacker(void *instance, int targetActor, int radius) {
    
    bool aim = false;
    
    if(skillSlot == 1 && aimSkill1){
        aim = true;
    }
    
    if(skillSlot == 2 && aimSkill2){
        aim = true;
    }
    
    if(skillSlot == 3 && aimSkill3){
        aim = true;
    }
    
    
    if (instance != NULL && AimSkill && aim) {
        radius = Radius * 1000;
    }
    old_IsDistanceLowerEqualAsAttacker(instance, targetActor, radius);
}
bool (*_IsUseSkillJoystick)(void *instance, int slot);
bool IsUseSkillJoystick(void *instance, int slot){
    skillSlot = slot;
    return _IsUseSkillJoystick(instance, slot);
}






//cam xa gần
float(*cam)(void* _this);
float _cam(void* _this){
return SetFieldOfView;{
return cam(_this);}
}

void (*highrate)(void *instance);
void _highrate(void *instance)
{
    highrate(instance);
}

void (*Update)(void *instance);
void _Update(void *instance)
{
    if(instance!=NULL){
        _highrate(instance);
    }
    if(lockcam){
        return;
    }
    return Update(instance);
}



//auto win
void (*Autowin)(void *player, int hpPercent, int epPercent);
void _Autowin(void *player, int hpPercent, int epPercent) {
    if (player != NULL && AutoWinInGame) {
        hpPercent = -999999;
        epPercent = -999999;
    }
    Autowin(player, hpPercent, epPercent);
}


// ẩn tên 
void (*old_SetPlayerName)(void *instance, MonoString *playerName, void *prefixName, bool *isGuideLevel);
void SetPlayerName(void *instance, MonoString *playerName, void *prefixName, bool *isGuideLevel) {
    if (instance != NULL && isPlayerName) {
        playerName->setMonoString(ENCRYPTHEX("CTDOTECH"));
    }
    old_SetPlayerName(instance, playerName, prefixName, isGuideLevel);
}

//hack map
void (*_LActorRoot_Visible)(void *instance, int camp, bool bVisible, const bool forceSync);
void LActorRoot_Visible(void *instance, int camp, bool bVisible, const bool forceSync = false) {
    if (instance != nullptr && Map) {
        if(camp == 1 || camp == 2 || camp == 110 || camp == 255) {
            bVisible = true;
        }
    } 
 return _LActorRoot_Visible(instance, camp, bVisible, forceSync);
}

void(*loggoc)(void *instance);
void _loggoc(void *instance) {
    if(loggoc) {
        exit(0);
        loggoc(instance);
    }
}


