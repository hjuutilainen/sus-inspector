//
//  SIReposadoConstants.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 11.7.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


#ifndef SUS_Inspector_SIReposadoConstants_h
#define SUS_Inspector_SIReposadoConstants_h

/*
 The version check is based on these
 */
#define kReposadoCurrentCommitDateString @"2019-03-07 08:06:45 -0800"
#define kReposadoCurrentCommitHash @"ed3a860de170df65eb88affe4b6d7312d419766c"


/*
 Reposado internal directory structure:
 
 kReposadoDefaultInstanceName
    |-- kReposadoDataDirectoryName
    |       |-- kReposadoHtmlDirectoryName
    |       |-- kReposadoDataDirectoryName
    |-- kReposadoBundleName
            |-- kReposadoCodeDirectoryName
 
 */
#define kReposadoDefaultInstanceName    @"Reposado"

#define kReposadoDataDirectoryName      @"data"
#define kReposadoMetadataDirectoryName  @"metadata"
#define kReposadoHtmlDirectoryName      @"html"

#define kReposadoBundleName             @"reposado.bundle"
#define kReposadoCodeDirectoryName      @"code"

#endif
